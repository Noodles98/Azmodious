namespace RoleCommandDelay {

const int DEFAULT_DELAY = 2 * SECOND;

dictionary nextFrameByKey;
dictionary pendingByKey;

int GetNextFrame(const string& in key)
{
	int frame = 0;
	nextFrameByKey.get(key, frame);
	return frame;
}

bool IsPending(const string& in key)
{
	bool pending = false;
	pendingByKey.get(key, pending);
	return pending;
}

void SetPending(const string& in key, bool value)
{
	pendingByKey.set(key, value);
}

bool IsReady(const string& in key)
{
	if (ai.frame >= GetNextFrame(key))
		return true;
	SetPending(key, true);
	return false;
}

void Commit(const string& in key, int delay = DEFAULT_DELAY)
{
	nextFrameByKey.set(key, ai.frame + delay);
	SetPending(key, false);
}

bool HasReadyPending(const string& in key)
{
	return IsPending(key) && (ai.frame >= GetNextFrame(key));
}

}  // namespace RoleCommandDelay
