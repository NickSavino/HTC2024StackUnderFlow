import { config } from '@tamagui/config/v3'
import { createTamagui } from 'tamagui'
import tokens from './tokens/tokens'

export const tamaguiConfig = createTamagui({
    tokens: tokens,
    themes: {
        light: {
          background: tokens.color.white,
          color: tokens.color.black,
        },
        dark: {
          background: tokens.color.black,
          color: tokens.color.white,
        },
      },
      fonts: {
        // Add your font configurations here
      },
      shorthands: {
        // Add shorthands for properties
      },
      config
})

const testConfig = createTamagui(config)


export default tamaguiConfig

export type Conf = typeof testConfig

declare module 'tamagui' {
  interface TamaguiCustomConfig extends Conf {}
}