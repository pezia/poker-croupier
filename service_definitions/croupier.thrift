
struct PlayerDefinition
{
    1:string name,
    2:string host,
    3:i16 port
}

service Croupier
{
    boolean register_player(1:PlayerDefinition player)

    void start_sit_and_go()
    // void start_live_action_game()
}