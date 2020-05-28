package utn.dao;

import utn.exceptions.AlreadyExistsException;
import utn.model.User;

public interface AbstractDao<T> {

    Object add(T value) throws AlreadyExistsException;

    void update(T value);

    void remove(Integer id);

    Object getById(Integer id);

}
