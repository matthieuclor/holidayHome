# frozen_string_literal: true

module MetaTagsHelper
  def meta_title
    content_for(:meta_title) || t('default_meta.meta_title')
  end

  def meta_description
    content_for(:meta_description) || t('default_meta.meta_description')
  end

  def meta_image
    image_url(content_for?(:meta_image) || t('default_meta.meta_image'))
  end

  def meta_image_alt
    content_for(:meta_image_alt) || t('default_meta.meta_image_alt')
  end

  def meta_product_name
    content_for(:meta_product_name) || t('default_meta.meta_product_name')
  end

  def meta_fb_app_id
    content_for(:meta_fb_app_id) || t('default_meta.fb_app_id')
  end
end
