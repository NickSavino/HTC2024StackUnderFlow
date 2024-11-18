import { ThemedView } from "@/components/ThemedView";
import { useState } from "react";
import { Dimensions, StyleSheet } from "react-native";
import MapView, { Marker } from "react-native-maps";


const MapScreen = () => {

    const [markers, setMarkers] = useState([
        {
            id: 1,
            title: "Marker 1",
            description: "Description for Marker 1",
            coordinate: {
                latitude: 37.78825,
                longitude: -122.4324,
            },
        },
        {
            id: 2,
            title: "Marker 2",
            description: "Description for Marker 2",
            coordinate: {
                latitude: 37.78925,
                longitude: -122.4334,
            },
        },
    ]);
    
    return (
        <ThemedView style={styles.container}>
            <MapView
                style={styles.map}
                initialRegion={{
                    latitude: 37.78825,
                    longitude: -122.4324,
                    latitudeDelta: 0.0922,
                    longitudeDelta: 0.0421,
                }}
            >
                {markers.map((marker) => (
                    <Marker
                        key={marker.id}
                        coordinate={marker.coordinate}
                        title={marker.title}
                        description={marker.description}
                    />
                ))}
            </MapView>
        </ThemedView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    map: {
        width: Dimensions.get("window").width,
        height: Dimensions.get("window").height,
    },
});


export default MapScreen;