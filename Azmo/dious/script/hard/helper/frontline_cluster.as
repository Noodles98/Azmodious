#include "lane_pathing.as"


namespace FrontlineCluster {

const float CONFIRM_RADIUS = 520.f;
const float ANCHOR_RADIUS = 640.f;

bool hasCandidate = false;
AIFloat3 candidatePos;
uint candidateHits = 0;
int candidateFrame = 0;

bool hasAnchor = false;
AIFloat3 anchorPos;
int anchorFrame = 0;

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

void ResetCandidate(const AIFloat3& in pos)
{
	hasCandidate = true;
	candidatePos = pos;
	candidateHits = 1;
	candidateFrame = ai.frame;
}

void SetAnchor(const AIFloat3& in pos)
{
	if (hasAnchor) {
		anchorPos = BlendTowards(anchorPos, pos, 3);
	} else {
		anchorPos = pos;
		hasAnchor = true;
		AiLog("Frontline anchor established at lane " + TeamLane::GetName());
	}
	anchorFrame = ai.frame;
	hasCandidate = false;
	candidateHits = 0;
}

bool HasStableAnchor()
{
	if (!hasAnchor)
		return false;
	if (ai.frame - anchorFrame > TeamRole::GetFrontlineAnchorExpire()) {
		hasAnchor = false;
		return false;
	}
	return true;
}

AIFloat3 UpdateAndGetPos(const AIFloat3& in pos, float laneSpread)
{
	const float confirmRadiusSq = CONFIRM_RADIUS * CONFIRM_RADIUS;
	const float anchorRadiusSq = ANCHOR_RADIUS * ANCHOR_RADIUS;
	const uint minConfirmHits = TeamRole::GetFrontlineConfirmHits();
	const int confirmWindow = TeamRole::GetFrontlineConfirmWindow();

	if (HasStableAnchor() && DistSq2D(pos, anchorPos) <= anchorRadiusSq) {
		anchorPos = BlendTowards(anchorPos, pos, 4);
		anchorFrame = ai.frame;
		return LanePathing::BiasMovePos(anchorPos, laneSpread);
	}

	if (!hasCandidate
		|| (ai.frame - candidateFrame > confirmWindow)
		|| (DistSq2D(pos, candidatePos) > confirmRadiusSq))
	{
		ResetCandidate(pos);
		return LanePathing::BiasMovePos(pos, laneSpread);
	}

	++candidateHits;
	candidateFrame = ai.frame;
	candidatePos = BlendTowards(candidatePos, pos, candidateHits);

	if (candidateHits >= minConfirmHits) {
		SetAnchor(candidatePos);
		return LanePathing::BiasMovePos(anchorPos, laneSpread);
	}

	return LanePathing::BiasMovePos(candidatePos, laneSpread);
}

}  // namespace FrontlineCluster