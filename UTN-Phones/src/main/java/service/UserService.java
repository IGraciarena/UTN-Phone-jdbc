package service;

import dao.UserDao;
import execptions.UserAlreadyExistsExecption;
import execptions.UserNotexistException;
import model.User;

import java.util.Optional;

public class UserService {

    UserDao dao;

    public UserService(UserDao dao) {
        this.dao = dao;
    }

    public User login(String userName, String password) throws UserNotexistException {
        User user = dao.getByUserName(userName, password);
        return Optional.ofNullable(user).orElseThrow(() -> new UserNotexistException());

    }

    public User add(User value) throws UserAlreadyExistsExecption {
        return dao.add(value);
    }

    public void updateUser(User user) {
        dao.update(user);
    }

    public void removeUser(User u) {
        dao.remove(u);
    }

}
