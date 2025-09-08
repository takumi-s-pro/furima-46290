document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  
  if (!priceInput) {
    return;
  }

  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = Number(priceInput.value);

    const fee = Math.floor(inputValue * 0.1);
    const gain = inputValue - fee;

    addTaxDom.innerHTML = fee.toLocaleString();
    profitDom.innerHTML = gain.toLocaleString();
  });
});