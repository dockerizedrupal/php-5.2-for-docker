class run::user {
  bash_exec { "usermod -o -u $user_id container": }

  bash_exec { "chown -h $user_id /home/container -R":
    require => Bash_exec["usermod -o -u $user_id container"]
  }

  bash_exec { "groupmod -o -g $group_id container": }

  bash_exec { "chgrp -h $group_id /home/container -R":
    require => Bash_exec["groupmod -o -g $group_id container"]
  }
}
