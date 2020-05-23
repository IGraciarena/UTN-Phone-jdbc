package utn.dao.mysql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import utn.dao.CityDao;
import utn.model.City;
import utn.model.Province;
import utn.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static utn.dao.mysql.MySQLUtils.*;

@Repository
public class CityMySQLDao implements CityDao {
    Connection con;

    @Autowired
    public CityMySQLDao(Connection con){
        this.con = con;
    }

    @Override
    public City getById(Integer id) {
        City c = null;
        try {
            PreparedStatement ps = con.prepareStatement(GETBYID_CITY_QUERY);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 c = createCity(rs);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    private City createCity(ResultSet rs) throws SQLException {
        City c = new City(rs.getInt("id_city"),rs.getString("city_name"),rs.getInt("prefix"),
                new Province(rs.getInt("id_province"),rs.getString("province_name")));
        return c;
    }

    @Override
    public List<City> getAll() {
        try {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(BASE_CITY_QUERY);
            List<City> userList = new ArrayList<>();
            while (rs.next()) {
                userList.add(createCity(rs));
            }
            st.close();
            rs.close();
            return userList;
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener la lista de ciudades", e);
        }
    }

    @Override
    public City add(City value) {
        try {
            PreparedStatement ps = con.prepareStatement(INSERT_CITY_QUERY, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1,value.getId());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs != null && rs.next()) {
                value.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al insertar city",e);
        }
        return value;
    }

    @Override
    public void remove(Integer id) {
        try {
            PreparedStatement ps = con.prepareStatement(REMOVE_CITY_QUERY);
            ps.setInt(1,id);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar provincia", e);
        }
    }

    @Override
    public void update(City value) {
        try {
            PreparedStatement ps = con.prepareStatement(UPDATE_CITY_QUERY);
            ps.setString(1,value.getCityName());
            ps.setInt(2,value.getPrefix());
            ps.setInt(3,value.getProvince().getId());
            ps.setInt(2,value.getId());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException("Error al modificar ciudad", e);
        }
    }
}