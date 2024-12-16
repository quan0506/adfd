package com.example.be_adfd.controller;

import com.example.be_adfd.entity.Place;
import com.example.be_adfd.service.PlaceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/places")
public class PlaceController {
    private final PlaceService placeService;

    public PlaceController(PlaceService placeService) {
        this.placeService = placeService;
    }

    @PostMapping
    public ResponseEntity<Place> addPlace(
            @RequestParam("name") String name,
            @RequestParam("rate") Double rate,
            @RequestParam("image") MultipartFile imageFile) {
        try {
            Place place = placeService.savePlace(name, rate, imageFile);
            return new ResponseEntity<>(place, HttpStatus.CREATED);
        } catch (IOException e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public List<Place> getAllPlaces() {
        return placeService.getAllPlaces();
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePlace(@PathVariable Long id) {
        try {
            placeService.deletePlaceById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
