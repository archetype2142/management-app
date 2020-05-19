# frozen_string_literal: true

module ApplicationHelper
  def available_countries
    countries = Country.all
    countries.collect do |country|
      country.name = I18n.t(country.iso, scope: 'country_names', default: country.name)
      country
    end
  end

  def fullname(user)
    return if user.addresses.empty?
    user.addresses&.first&.company || "#{user.addresses&.first&.firstname} #{user.addresses&.first&.lastname}"
  end

  def available_states(country_id)
    State.where(
      country: Country.find(country_id)
    )
  end

  # def display_price(product_or_variant)
  #   humanized_money ( product_or_variant.
  #   price_in(current_currency).
  #   display_price_including_vat_for(current_price_options) )
  # end

  def display_price(product_or_variant)
    money = Monetize.parse(product_or_variant.price)
    "<p class='amount'> #{money} <span class='symbol'> #{money.currency.symbol}</span></p>".html_safe
  end

  def current_currency
    'PLN'
  end

  def current_store
    @current_store ||= Store.current(request.env['SERVER_NAME'])
  end

  def current_price_options
    {
      tax_zone: current_tax_zone
    }
  end

  def current_tax_zone
    @current_tax_zone ||= @current_order&.tax_zone || Zone.default_tax
  end

  def default_image_for_product(product)
    if product.default_variant.images.any?
      product.default_variant.images.first
    elsif product.variant_images.any?
      product.variant_images.first
    end
  end

  def default_image_for_product_or_variant(product_or_variant)
    Rails.cache.fetch("default-image/#{product_or_variant.cache_key_with_version}") do
      if product_or_variant.is_a?(Product)
        default_image_for_product(product_or_variant)
      elsif product_or_variant.is_a?(Variant)
        if product_or_variant.images.any?
          product_or_variant.images.first
        else
          default_image_for_product(product_or_variant.product)
        end
      end
    end
  end

  def currency_codes(which: [])
    currencies = []
    Money::Currency.table.values.each do |currency|
      if which.any?
        next unless which.include?(currency[:iso_code])
      end
      currencies = currencies + [[currency[:name] + ' (' + currency[:iso_code] + ')', currency[:iso_code]]]
    end
    currencies
  end

end
