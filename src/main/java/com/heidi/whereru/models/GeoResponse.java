package com.heidi.whereru.models;

import java.util.List;

public class GeoResponse {
    public List<Result> results;
    String status;

    
    
    
    public static class Result {
        List<AddressComponent> address_components;
        String formatted_address;
        public Geometry geometry;
        boolean partial_match;
        String place_id;
        List<String> types;

        static class AddressComponent {
            String long_name, short_name;
            List<String> types;
        }

        public static class Geometry {
            Rect bounds;
            public LatLng location;
            String location_type;
            Rect viewport;

            static class Rect {
                LatLng northeast, southwest;
            }

            public static class LatLng {
                public double lat, lng;
            }
        }
    }
}

