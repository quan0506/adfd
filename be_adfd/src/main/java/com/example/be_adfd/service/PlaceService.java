package com.example.be_adfd.service;

import com.example.be_adfd.entity.Place;
import com.example.be_adfd.repository.PlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;


@Service
public class PlaceService {
    private final PlaceRepository placeRepository;

    public PlaceService(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    public Place savePlace(String name, Double rate, MultipartFile imageFile) throws IOException {
        Place place = new Place();
        place.setName(name);
        place.setRate(rate);
        place.setImage(imageFile.getBytes());
        return placeRepository.save(place);
    }

    public List<Place> getAllPlaces() {
        return placeRepository.findAll();
    }

    public void deletePlaceById(Long id) {
        placeRepository.deleteById(id);
    }
}
