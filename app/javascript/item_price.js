window.addEventListener('load', () => {
    // 金額を入力した数値をpriceInputという変数に格納する
    const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", function(){
        const addTaxDom = document.getElementById("add-tax-price");
        const intProfit = document.getElementById("profit")
        addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1)
        intProfit.innerHTML = Math.floor(priceInput.value - addTaxDom.innerHTML)
    // 価格から、手数料を計算
    // 表示させる
})

});