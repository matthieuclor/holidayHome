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

  def meta_image_type
    content_for(:meta_image_type) || t('default_meta.meta_image_type')
  end

  def meta_image_width
    content_for(:meta_image_width) || t('default_meta.meta_image_width')
  end

  def meta_image_height
    content_for(:meta_image_height) || t('default_meta.meta_image_height')
  end
end
