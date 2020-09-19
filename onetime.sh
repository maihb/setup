#!/usr/local/bin/expect -f
trap {
    set rows [stty rows]
    set cols [stty columns]
    stty rows $rows columns $cols < $spawn_out(slave,name)
} WINCH
#set timeout 3
spawn ssh [lindex $argv 0]@[lindex $argv 2]
expect {
        "(yes/no)?"
        {send "yes\n";exp_continue}
        "password:"
        {send "[lindex $argv 1]\n"}
}
spawn su - root 
expect {
        "Password:"
        {send "233131\n"}
}
interact
#expect eof
