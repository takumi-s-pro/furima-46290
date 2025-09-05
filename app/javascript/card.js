const pay = () => {
  const numberElementDiv = document.getElementById('number-form');
  if (!numberElementDiv) return;

  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");

        const existingToken = renderDom.querySelector("input[name='token']");
        if (existingToken) {
          existingToken.remove();
        }

        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
      }

      const submitBtn = form.querySelector('input[type="submit"]');
      if(submitBtn){
        submitBtn.disabled = true;
      }

      form.submit();
    });
  });
};

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);