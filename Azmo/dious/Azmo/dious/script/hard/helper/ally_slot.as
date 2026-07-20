namespace TeamSlot {

const string MESSAGE_PREFIX = "ALLY_SLOT:";
const int RESEND_INTERVAL = 5 * SECOND;
const int LOCK_FRAME = 10 * SECOND;

array<int> knownTeamIds = {};
int lastBroadcastFrame = -RESEND_INTERVAL;
bool isLocked = false;

bool Contains(int teamId)
{
	for (uint i = 0; i < knownTeamIds.length(); ++i) {
		if (knownTeamIds[i] == teamId)
			return true;
	}
	return false;
}

void InsertSorted(int teamId)
{
	if (Contains(teamId))
		return;

	for (uint i = 0; i < knownTeamIds.length(); ++i) {
		if (teamId < knownTeamIds[i]) {
			knownTeamIds.insertAt(i, teamId);
			return;
		}
	}
	knownTeamIds.insertLast(teamId);
}

void Broadcast()
{
	AiSendMessage(MESSAGE_PREFIX + ai.teamId);
	lastBroadcastFrame = ai.frame;
}

void Init()
{
	InsertSorted(ai.teamId);
	Broadcast();
}

void OnSlowUpdate()
{
	InsertSorted(ai.teamId);
	if (!isLocked && (ai.frame - lastBroadcastFrame >= RESEND_INTERVAL))
		Broadcast();
	if (!isLocked && (ai.frame >= LOCK_FRAME))
		isLocked = true;
}

void OnMessage(const string& in data)
{
	if (data.findLast(MESSAGE_PREFIX, 0) != 0)
		return;
	InsertSorted(parseInt(data.substr(MESSAGE_PREFIX.length())));
}

int ResolveSlot()
{
	InsertSorted(ai.teamId);
	for (uint i = 0; i < knownTeamIds.length(); ++i) {
		if (knownTeamIds[i] == ai.teamId)
			return i % 8;
	}
	return 0;
}

uint GetKnownCount()
{
	return knownTeamIds.length();
}

}  // namespace TeamSlot