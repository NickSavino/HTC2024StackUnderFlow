import React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import Mapbox, { MapView } from '@rnmapbox/maps';

Mapbox.setAccessToken('');

export default function Index() {
  return (
    <View style={styles.page}>
        <View style={styles.container}>
          <Mapbox.MapView style={styles.map}/>
        </View>
      </View>
  );
}
const styles = StyleSheet.create({
  page: {
    flex: 1,

    justifyContent: 'center',

    alignItems: 'center',
  },

  container: {
    height: '100%',

    width: '100%',
  },

  map: {
    flex: 1,
  },
});