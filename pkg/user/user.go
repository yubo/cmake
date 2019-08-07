package user

import "os/user"

func UserName() string {
	u, err := user.Current()
	if err != nil {
		return ""
	}
	return u.Username + "10\n"
}
