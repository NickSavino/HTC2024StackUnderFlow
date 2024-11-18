import React from 'react'
import { SafeAreaView } from 'react-native-safe-area-context';
import { XStack, YStack, ZStack } from 'tamagui'

export function StacksDemo() {
  return (
    <SafeAreaView>
    <XStack maxWidth={250} padding="$2" alignSelf="center" gap="$2">
      <YStack
        flex={1}
        borderWidth={2}
        borderColor="$color"
        borderRadius="$md"
        gap="$2"
        padding="$2"
      >
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
      </YStack>

      <XStack
        flex={1}
        borderWidth={2}
        borderColor="$color"
        borderRadius="$md"
        gap="$2"
        padding="$2"
      >
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
        <YStack backgroundColor="$color" borderRadius="$md" padding="$2" />
      </XStack>

      <ZStack maxWidth={50} maxHeight={85} width={100} flex={1}>
        <YStack
          fullscreen
          borderRadius="$md"
          padding="$2"
          borderColor="$color"
          borderWidth={2}
        />
        <YStack
          borderColor="$color"
          fullscreen
          y={10}
          x={10}
          borderWidth={2}
          borderRadius="$md"
          padding="$2"
        />
        <YStack
          borderColor="$color"
          fullscreen
          y={20}
          x={20}
          borderWidth={2}
          borderRadius="$md"
          padding="$2"
        />
      </ZStack>
    </XStack>
    </SafeAreaView>
  )
}

export default StacksDemo;