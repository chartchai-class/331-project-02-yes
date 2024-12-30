<template>
  <div class="medal-summary">
    <h1>{{ countryInfo.country }} Country Details</h1>
    <h2>Country Overview</h2>
    <p>{{ countryInfo.description }}</p>
    <h2>Total Medals Won</h2>
    <div class="medal-info">
      <p>
        <img src="@/assets/gold-medal.png" alt="Gold Medal" class="medal-icon" />
        <span class="medal-text">Gold: {{ countryInfo.gold }}</span>
      </p>
      <p>
        <img src="@/assets/silver-medal.png" alt="Silver Medal" class="medal-icon" />
        <span class="medal-text">Silver: {{ countryInfo.silver }}</span>
      </p>
      <p>
        <img src="@/assets/bronze-medal.png" alt="Bronze Medal" class="medal-icon" />
        <span class="medal-text">Bronze: {{ countryInfo.bronze }}</span>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  props: ['countryInfo']
};
</script>

<style scoped>
.medal-summary {
  text-align: center;
}

.medal-info p {
  display: flex;
  align-items: center;
  justify-content: center;
}

.medal-icon {
  width: 30px;
  height: 30px;
  margin-right: 5px;
}

.medal-text {
  vertical-align: middle;
}
</style>
