const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);

    const fee = Math.floor(price * 0.1);
    const gain = price - fee;

    addTaxDom.innerHTML = fee.toLocaleString();
    profitDom.innerHTML = gain.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);