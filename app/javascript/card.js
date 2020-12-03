const pay = () => {
  // pk_test_******************はPay.jpのマイページから確認できる
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  // submitボタンをユーザーが押したら、preventDefaultで一旦何もさせないようにする
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    // formDataにはクレジットカード情報や配送先情報が格納される
    const formData = new FormData(formResult);

    const card = {
      // 「numberやcvc」はPay.jp側で指定されたキーの名前
      // これは連想配列。左がキー、右がバリュー
      // getの中のname属性を取得する
      number: formData.get("item_user[card-number]"),
      cvc: formData.get("item_user[card-cvc]"),
      exp_month: formData.get("item_user[card-month]"),
      exp_year: `20${formData.get("item_user[card-year]")}`,
    };
    // console.log(card)
    // Payjp〜〜はpayjpのgemで定義されているメソッド
    Payjp.createToken(card, (status, response) => {
      // status==200はPayjpからレスポンスが返ってきた時
      console.log(status)
      if (status == 200) {
        const token = response.id;
        // console.log(token)
        const renderDom = document.getElementById("charge-form");
        // token用の要素を作成する。ただし見れないようにhiddenにしている
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        // ここでHTML上に表示させる（隠れてるけど）
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // text_fieldのカラム名＝name属性の存在を消去（することでrails側にデータを送信されなくなる）
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // 6,7行目で停止したsubmitをjsで実行させる
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);


// 【webpackerを再起動したい時】
// furimaのディレクトリでターミナルで実行
// ./bin/webpack
// Javascriptが正しく記述されてるにもかかわらずエラーになることがある
// その時は上記コマンドを実行してwebpackerを再リロードすると直ることがあるらしい