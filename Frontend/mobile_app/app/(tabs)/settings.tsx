import { ThemedView } from "@/components/ThemedView";
import styles from "@/constants/Styles";
import { themes } from "@tamagui/config/v3";
import { SafeAreaView } from "react-native-safe-area-context";
import { Text, View, Button, Stack, ScrollView } from "tamagui";

const SettingsScreen = () => {
  return (
    <SafeAreaView style={ styles.container }>
        <ScrollView>
      <Stack alignItems="center">
        <Text fontSize="$12" color="$color" fontWeight="bold">
          Settings Screen
        </Text>
        <Text fontSize="$4" color="$gray1">
          Customize your application preferences below.
        </Text>

        <Button theme="dark" onPress={() => alert("Clicked!")}>
          Change Theme
        </Button>
      </Stack>
      </ScrollView>
      </SafeAreaView>
  );
};

export default SettingsScreen;

