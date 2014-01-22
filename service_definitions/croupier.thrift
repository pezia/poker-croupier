namespace rb API
namespace php API
namespace cpp API
namespace csharp API

namespace java com.devillsroom.poker.client

service Croupier
{
    void register_player(1:string address)

    void start_sit_and_go()

    oneway void shutdown()
}