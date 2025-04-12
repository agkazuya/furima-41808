document.addEventListener('DOMContentLoaded', function() {
  const priceInput = document.getElementById('item-price');
  const feeDisplay = document.getElementById('add-tax-price');
  const profitDisplay = document.getElementById('profit');

  priceInput.addEventListener('input', function() {
    const price = parseFloat(priceInput.value);
    if (!isNaN(price)) {
      const fee = calculateFee(price);
      const profit = calculateProfit(price, fee);

      feeDisplay.textContent = fee;
      profitDisplay.textContent = profit;
    } else {
      feeDisplay.textContent = '';
      profitDisplay.textContent = '';
    }
  });

  function calculateFee(price) {
    return Math.floor(price * 0.1);  // 例：10%の手数料
  }

  function calculateProfit(price, fee) {
    return price - fee;
  }
});

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);