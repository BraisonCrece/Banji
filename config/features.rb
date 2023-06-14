Flipflop.configure do
  # Strategies will be used in the order listed here.
  strategy UserFeatureStrategy

  # Features definition
  feature :filtering_bar,
    default: false,
    description: "Filter products"
end
