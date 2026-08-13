#include "lane_pathing.as"


namespace FrontlineCluster {

const float CONFIRM_RADIUS = 400.f;
const float ANCHOR_RADIUS = 500.f;
const float ANCHOR_MERGE_RADIUS = 350.f;
const float PUSH_START_RADIUS = 450.f;
const float PUSH_MAX_RADIUS = 650.f;
const float PUSH_RATIO = 4.22f;
const uint MAX_FRONTLINE_ANCHORS = 3;
const int ENEMY_MEMORY_EXPIRE = 90 * SECOND;

array<AIFloat3> candidatePositions;
array<uint> candidateHits;
array<int> candidateFrames;

array<AIFloat3> anchorPositions;
array<int> anchorFrames;

bool hasLastKnownEnemyPos = false;
AIFloat3 lastKnownEnemyPos;
int lastKnownEnemyFrame = -1;

void RememberEnemyPos(const AIFloat3& in pos)
{
	hasLastKnownEnemyPos = true;
	lastKnownEnemyPos = pos;
	lastKnownEnemyFrame = ai.frame;
}

bool HasFreshEnemyMemory()
{
	if (!hasLastKnownEnemyPos)
		return false;
	if (ai.frame - lastKnownEnemyFrame > ENEMY_MEMORY_EXPIRE) {
		hasLastKnownEnemyPos = false;
		return false;
	}
	return true;
}

float DistSq2D(const AIFloat3& in a, const AIFloat3& in b)
{
	const float dx = a.x - b.x;
	const float dz = a.z - b.z;
	return dx * dx + dz * dz;
}

AIFloat3 BlendTowards(const AIFloat3& in into, const AIFloat3& in pos, uint count)
{
	const float inv = 1.f / float(count);
	AIFloat3 blended = into;
	blended.x += (pos.x - blended.x) * inv;
	blended.y += (pos.y - blended.y) * inv;
	blended.z += (pos.z - blended.z) * inv;
	return blended;
}

AIFloat3 PushTowardsPressure(const AIFloat3& in anchor, const AIFloat3& in pressure)
{
	const float dx = pressure.x - anchor.x;
	const float dz = pressure.z - anchor.z;
	const float distSq = dx * dx + dz * dz;
	const float startSq = PUSH_START_RADIUS * PUSH_START_RADIUS;
	if (distSq <= startSq)
		return anchor;

	AIFloat3 pushed = anchor;
	float pushX = dx * PUSH_RATIO;
	float pushZ = dz * PUSH_RATIO;
	if (pushX > PUSH_MAX_RADIUS)
		pushX = PUSH_MAX_RADIUS;
	else if (pushX < -PUSH_MAX_RADIUS)
		pushX = -PUSH_MAX_RADIUS;
	if (pushZ > PUSH_MAX_RADIUS)
		pushZ = PUSH_MAX_RADIUS;
	else if (pushZ < -PUSH_MAX_RADIUS)
		pushZ = -PUSH_MAX_RADIUS;
	pushed.x += pushX;
	pushed.z += pushZ;
	pushed.y = pressure.y;
	return pushed;
}

int FindNearestAnchor(const AIFloat3& in pos, float radius)
{
	const float radiusSq = radius * radius;
	float bestDistSq = radiusSq;
	int bestIndex = -1;
	for (uint i = 0; i < anchorPositions.length(); ++i) {
		const float distSq = DistSq2D(pos, anchorPositions[i]);
		if (distSq <= bestDistSq) {
			bestDistSq = distSq;
			bestIndex = int(i);
		}
	}
	return bestIndex;
}

int FindNearestCandidate(const AIFloat3& in pos)
{
	const float confirmRadiusSq = CONFIRM_RADIUS * CONFIRM_RADIUS;
	float bestDistSq = confirmRadiusSq;
	int bestIndex = -1;
	for (uint i = 0; i < candidatePositions.length(); ++i) {
		if (ai.frame - candidateFrames[i] > TeamRole::GetFrontlineConfirmWindow())
			continue;
		const float distSq = DistSq2D(pos, candidatePositions[i]);
		if (distSq <= bestDistSq) {
			bestDistSq = distSq;
			bestIndex = int(i);
		}
	}
	return bestIndex;
}

int FindOldestAnchor()
{
	int oldestIndex = 0;
	for (uint i = 1; i < anchorFrames.length(); ++i) {
		if (anchorFrames[i] < anchorFrames[uint(oldestIndex)])
			oldestIndex = int(i);
	}
	return oldestIndex;
}

void RemoveCandidate(uint index)
{
	candidatePositions.removeAt(index);
	candidateHits.removeAt(index);
	candidateFrames.removeAt(index);
}

void PruneExpiredAnchors()
{
	for (int i = int(anchorPositions.length()) - 1; i >= 0; --i) {
		if (ai.frame - anchorFrames[uint(i)] > TeamRole::GetFrontlineAnchorExpire()) {
			anchorPositions.removeAt(uint(i));
			anchorFrames.removeAt(uint(i));
		}
	}
}

void ResetCandidate(const AIFloat3& in pos)
{
	if (candidatePositions.length() >= MAX_FRONTLINE_ANCHORS)
		RemoveCandidate(0);
	candidatePositions.insertLast(pos);
	candidateHits.insertLast(1);
	candidateFrames.insertLast(ai.frame);
}

void SetAnchor(const AIFloat3& in pos)
{
	PruneExpiredAnchors();

	const int nearbyAnchor = FindNearestAnchor(pos, ANCHOR_MERGE_RADIUS);
	if (nearbyAnchor >= 0) {
		anchorPositions[uint(nearbyAnchor)] = BlendTowards(anchorPositions[uint(nearbyAnchor)], pos, 3);
		anchorFrames[uint(nearbyAnchor)] = ai.frame;
		return;
	}

	if (anchorPositions.length() < MAX_FRONTLINE_ANCHORS) {
		anchorPositions.insertLast(pos);
		anchorFrames.insertLast(ai.frame);
	} else {
		const uint replaceIndex = uint(FindOldestAnchor());
		anchorPositions[replaceIndex] = pos;
		anchorFrames[replaceIndex] = ai.frame;
	}

	AiLog("Frontline anchor established at lane " + TeamLane::GetName()
		+ " (restriction=" + TeamLane::GetRestrictionName()
		+ ", anchors=" + anchorPositions.length() + ")");
}

bool HasStableAnchor()
{
	PruneExpiredAnchors();
	return anchorPositions.length() > 0;
}

bool GetAttackFocus(const AIFloat3& in fromPos, AIFloat3& out focusPos)
{
	if (!HasStableAnchor()) {
		if (!HasFreshEnemyMemory())
			return false;
		focusPos = LanePathing::BiasMovePos(lastKnownEnemyPos, TeamRole::GetDefenceLaneSpread());
		return true;
	}
	int anchorIndex = FindNearestAnchor(fromPos, 999999.f);
	if (anchorIndex < 0)
		anchorIndex = 0;
	focusPos = LanePathing::BiasMovePos(anchorPositions[uint(anchorIndex)], TeamRole::GetDefenceLaneSpread());
	return true;
}

void ObservePressure(const AIFloat3& in pos)
{
	PruneExpiredAnchors();
	RememberEnemyPos(pos);

	const uint minConfirmHits = TeamRole::GetFrontlineConfirmHits();
	const int nearbyAnchor = FindNearestAnchor(pos, ANCHOR_MERGE_RADIUS);

	if (nearbyAnchor >= 0) {
		anchorPositions[uint(nearbyAnchor)] = BlendTowards(anchorPositions[uint(nearbyAnchor)], pos, 4);
		anchorFrames[uint(nearbyAnchor)] = ai.frame;
		return;
	}

	int candidateIndex = FindNearestCandidate(pos);
	if (candidateIndex < 0) {
		ResetCandidate(pos);
		return;
	}

	const uint index = uint(candidateIndex);
	++candidateHits[index];
	candidateFrames[index] = ai.frame;
	candidatePositions[index] = BlendTowards(candidatePositions[index], pos, candidateHits[index]);

	if (candidateHits[index] >= minConfirmHits) {
		const AIFloat3 anchorPos = candidatePositions[index];
		SetAnchor(anchorPos);
		RemoveCandidate(index);
		return;
	}

	return;
}

bool GetDefenceFocus(const AIFloat3& in fromPos, float laneSpread, AIFloat3& out focusPos)
{
	PruneExpiredAnchors();
	if (!HasStableAnchor())
		return false;

	int anchorIndex = FindNearestAnchor(fromPos, 999999.f);
	if (anchorIndex < 0)
		anchorIndex = 0;

	const AIFloat3 anchorPos = anchorPositions[uint(anchorIndex)];
	focusPos = LanePathing::BiasBuildPos(anchorPos, laneSpread);
	return true;
}

AIFloat3 UpdateAndGetPos(const AIFloat3& in pos, float laneSpread)
{
	AIFloat3 anchorPos;
	if (GetDefenceFocus(pos, laneSpread, anchorPos))
		return anchorPos;

	return LanePathing::BiasMovePos(pos, laneSpread);
}

}  // namespace FrontlineCluster