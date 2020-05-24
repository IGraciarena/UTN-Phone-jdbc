package utn.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import utn.dao.PhoneCallDao;
import utn.dto.PhoneCallDto;
import utn.dto.ReturnedPhoneCallDto;
import utn.exceptions.AlreadyExistsException;
import utn.exceptions.NoExistsException;
import utn.model.PhoneCall;

import java.util.List;
import java.util.Optional;

@Service
public class PhoneCallService {
    PhoneCallDao dao;

    @Autowired
    public PhoneCallService(PhoneCallDao dao) {
        this.dao = dao;
    }

    public ReturnedPhoneCallDto getById(Integer id) throws NoExistsException {
        ReturnedPhoneCallDto phoneCall = dao.getById(id);
        Optional.ofNullable(phoneCall).orElseThrow(NoExistsException::new);
        return phoneCall;
    }

    public void add(PhoneCall phoneCall) throws AlreadyExistsException {
        dao.add(phoneCall);
    }

    public void remove(Integer id) throws NoExistsException {
        ReturnedPhoneCallDto phoneCall = dao.getById(id);
        Optional.ofNullable(phoneCall).orElseThrow(NoExistsException::new);
        dao.remove(id);
    }

    public void update(PhoneCall value) throws NoExistsException {
        ReturnedPhoneCallDto phoneCall = dao.getById(value.getId());
        Optional.ofNullable(phoneCall).orElseThrow(NoExistsException::new);
        dao.update(value);
    }

    public void addPhoneCall(PhoneCallDto phoneCall) {
        dao.addPhoneCall(phoneCall);
    }

    public List<ReturnedPhoneCallDto> getAll() {
        return dao.getAll();
    }

    public List<ReturnedPhoneCallDto> getAllPhoneCallsFromUserId(Integer userId) {
        return dao.getAllPhoneCallsFromUserId(userId);
    }
}
