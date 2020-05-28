package utn.dao;

import utn.dto.RateDto;
import utn.model.Rate;

import java.util.List;

public interface RateDao extends AbstractDao<Rate> {
    RateDto getById(Integer id);

    Rate add(Rate rate);

    List<RateDto> getAll();
}
