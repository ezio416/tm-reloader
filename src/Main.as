// c 2025-03-26
// m 2025-03-26

const string  pluginColor = "\\$FFF";
const string  pluginIcon  = Icons::Arrows;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

Meta::Plugin@[] queue;

void Main() {
    while (true) {
        yield();

        while (queue.Length > 0) {
            if (queue[0] !is null)
                Meta::ReloadPlugin(queue[0]);

            queue.RemoveAt(0);

            yield();
        }
    }
}

namespace Reloader {
    void ReloadMe() {
        queue.InsertLast(Meta::ExecutingPlugin());
    }
}
