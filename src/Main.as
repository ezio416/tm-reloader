// c 2025-03-26
// m 2025-03-26

Meta::Plugin@[] queue;

void Main() {
    string id;
    uint64 start;

    while (true) {
        yield();

        while (queue.Length > 0) {
            if (queue[0] !is null) {
                id = queue[0].ID;
                start = Time::Now;
                Meta::ReloadPlugin(queue[0]);
                warn("reloading " + id + " took " + (Time::Now - start) + "ms");
            }

            queue.RemoveAt(0);

            yield();
        }
    }
}

namespace Reloader {
    void ReloadMe() {
        Meta::Plugin@ executing = Meta::ExecutingPlugin();
        if (queue.FindByRef(executing) == -1)
            queue.InsertLast(@executing);
    }
}
