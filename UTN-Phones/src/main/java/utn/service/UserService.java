package utn.service;

import utn.dao.UserDao;
import utn.exceptions.UserAlreadyExistsException;
import utn.exceptions.UserNotexistException;
import utn.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class UserService {

    private UserDao dao;
    @Autowired
    public UserService(UserDao dao) {
        this.dao = dao;
    }

    public User login(String userName, String password) throws UserNotexistException {
        User user = dao.getByUserName(userName, password);
        return Optional.ofNullable(user).orElseThrow(() -> new UserNotexistException());

    }

    public User add(User value) throws UserAlreadyExistsException {
        return dao.add(value);
    }

    public void updateUser(User user) throws UserNotexistException {
        User byId = dao.getById(user.getId());
        Optional.ofNullable(byId).orElseThrow(UserNotexistException::new);
        dao.update(user);
    }

    public void removeUser(Integer idUser) throws UserNotexistException {
        User user = dao.getById(idUser);
        Optional.ofNullable(user).orElseThrow(UserNotexistException::new);
        dao.remove(idUser);
    }

    public User getById(Integer id){
        return dao.getById(id);
    }

}
