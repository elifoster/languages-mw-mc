require 'sinatra'

# This hash was created by xbony2, with some minor modifications by elifoster.
LANGUAGES = {
  'af_ZA' => 'af',
  'ar_SA' => 'ar',
  'ast_ES' => 'ast',
  'be_BY' => 'be',
  'bg_BG' => 'bg',
  'br_FR' => 'br',
  'ca_ES' => 'ca',
  'cs_CZ' => 'cs',
  'cy_GB' => 'cy',
  'da_DK' => 'da',
  'de_DE' => 'de',
  'el_GR' => 'el',
  'en_AU' => '',
  'en_CA' => 'en-ca',
  'en_GB' => 'en-gb',
  'en_NZ' => '',
  'en_PT' => '',
  'en_US' => 'en',
  'eo_UY' => 'eo',
  'es_AR' => 'es-ni',
  'es_ES' => 'es',
  'es_MX' => 'es',
  'es_UY' => 'es-ni',
  'es_VE' => 'es-ni',
  'et_EE' => 'et',
  'eu_ES' => 'eu',
  'fa_IR' => 'fa',
  'fi_FI' => 'fi',
  'fil_PH' => 'tl',
  'fo_FO' => 'fo',
  'fr_FR' => 'fr',
  'fr_CA' => '',
  'fy_NL' => 'fy',
  'ga_IE' => 'ga',
  'gl_ES' => 'gl',
  'gv_IM' => 'gv',
  'he_IL' => 'he',
  'hi_IN' => 'hi',
  'hr_HR' => 'hr',
  'hu_HU' => 'hu',
  'hy_AM' => 'hy',
  'id_ID' => 'id',
  'is_IS' => 'is',
  'it_IT' => 'it',
  'ja_JP' => 'ja',
  'jbo_EN' => 'jbo',
  'ka_GE' => 'ka',
  'ko_KR' => 'ko',
  'ksh_DE' => 'ksh',
  'kw_GB' => 'kw',
  'la_VA' => 'la',
  'lb_LU' => 'lb',
  'li_LI' => 'li',
  'lol_US' => '',
  'lt_LT' => 'lt',
  'lv_LV' => 'lv',
  'mi_NZ' => 'mi',
  'mk_MK' => 'mk',
  'ms_MY' => 'ms',
  'mt_MT' => 'mt',
  'nds_DE' => 'nds',
  'nl_NL' => 'nl',
  'nn_NO' => 'nn',
  'no_NO' => ['nb', 'no'],
  'oc_FR' => 'oc',
  'pl_PL' => 'pl',
  'pt_BR' => 'pt-br',
  'pt_PT' => 'pt',
  'qya_AA' => '',
  'ro_RO' => 'ro',
  'ru_RU' => 'ru',
  'se_NO' => 'se',
  'sk_SK' => 'sk',
  'sl_SI' => 'sl',
  'so_SO' => 'so',
  'sq_AL' => 'sq',
  'sr_SP' => 'sr',
  'sv_SE' => 'sv',
  'th_TH' => 'th',
  'tl_PH' => 'tl',
  'tlh_AA' => '',
  'tr_TR' => 'tr',
  'tzl_TZL' => '',
  'uk_UA' => 'uk',
  'va_ES' => 'va',
  'vi_VN' => 'vi',
  'zh_CN' => 'zh-cn',
  'zh_TW' => 'zh-tw'
}.freeze

# Gets whether the value is a valid HTML parameter.
# @param val [Any] The value to check. It should ideally be a string.
# @return [Boolean] Whether the value is not nil, empty, or anything but a String.
def valid_param?(val)
  !val.nil? && val.is_a?(String) && !val.empty?
end

# Outputs the MediaWiki language code for the provided Minecraft language code.
get '/mw' do
  halt(400, 'No lang parameter provided.'.freeze) unless valid_param?(params[:lang])
  halt(404, 'Language not found.'.freeze) unless LANGUAGES.key?(params[:lang])

  lang = LANGUAGES[params[:lang]]
  if lang.is_a?(String)
    halt(404, 'Language has no MW equivalent.') if lang.empty?
    lang
  elsif lang.is_a?(Array)
    lang.join(', ')
  end
end

# Outputs the Minecraft language code for the provided MediaWiki language code.
get '/mc' do
  halt(400, 'No lang parameter provided.'.freeze) unless valid_param?(params[:lang])

  lang = ''
  LANGUAGES.each_value do |val|
    if val.is_a?(String)
      lang = val if val == params[:lang]
    elsif val.is_a?(Array)
      val.each do |v|
        lang = val if v == params[:lang]
      end
    end
    break unless lang.empty?
  end
  halt(404, 'Language not found.'.freeze) if lang.empty?

  LANGUAGES.key(lang)
end
