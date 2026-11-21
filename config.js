/* =========================================================
   Supabase の接続設定
   Supabase ダッシュボード → Project Settings → API（または Data API）
   にある値をコピーして貼り付けてください。

   ・SUPABASE_URL      … Project URL（https://xxxx.supabase.co）
   ・SUPABASE_ANON_KEY … anon / public キー（publishable key）

   ※ anon キーはブラウザに置いて大丈夫な「公開用」のキーです。
     データは supabase.sql の RLS で本人しか触れないよう守られます。
   ※ service_role キー（secret key）は絶対にここに書かないこと！
   ========================================================= */
window.MEBAE_CONFIG = {
  SUPABASE_URL: "https://zdiuzshsupplwvwyfrff.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_-eCVLh-iUlnO6t3jD5BP9Q_OiWUxCuK",
};
