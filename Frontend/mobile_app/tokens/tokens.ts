import { createTokens } from "tamagui";

const tokens = createTokens({
  size: {
    // Define sizes for various components
    xs: 4,
    sm: 8,
    md: 16,
    true: 16, // default size
    lg: 24,
    xl: 32,
  },
  color: {
    // Define your color palette
    red: "#FF0000",
    blue: "#0000FF",
    green: "#00FF00",
    white: "#FFFFFF",
    black: "#000000",
    gray: "#808080",
  },
  space: {
    // Define spacing for margins/padding
    none: 0,
    xs: 4,
    sm: 8,
    md: 16,
    true: 16,
    lg: 24,
    xl: 32,
  },
  radius: {
    // Define border radius values
    none: 0,
    sm: 4,
    md: 8,
    true: 8,
    lg: 16,
    full: 9999, // For circular or fully-rounded components
  },
  zIndex: {
    // Define z-index values for layering
    xs: 1,
    sm: 10,
    md: 100,
    true: 100,
    lg: 1000,
    xl: 10000
  },
});

export default tokens;
