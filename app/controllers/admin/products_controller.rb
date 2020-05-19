module Admin
  class ProductsController < ::ApplicationController  
    helper ProductsHelper
    layout 'layouts/application'
    
    before_action :set_product, only: [:show, :update, :destroy]
    helper_method :all_products
    
    def new; end

    def index
      @products = Product.all

      respond_to do |format|
        format.html
        format.json { render json: @products }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @product }
      end
    end

    def create
      @product = Product.new(product_params)
      puts "\n\n\n\n #{params} \n\n\n\n"

      if params['product_image']
        im = Image.create!(image_params)
        @product.images << im
      end

      if @product.save
        redr = admin_product_path(@product)
        notice = { notice: "created new product" }
      else
        redr = new_admin_product_path
        notice = { alert: @product.errors }
      end

      redirect_to redr, flash: notice
        
    end

    def update
      if @product.update(product_params)
        respond_to do |format|
          format.html
          format.json { render json: @product }
        end
      else
        respond_to do |format|
          format.html
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @product.destroy
    end

    private

    def set_product
      @product = Product.find_by!(slug: params[:id])
    end
    
    def image_params
      {
        attachment: {
          io: params['product_image'],
          filename: params['product_image']
        }
      }
    end
    
    def product_params
      {
        name: params[:product]['name'],
        sku: params[:product]['sku'],
        price: Monetize.parse("#{params[:product]['price']} #{params[:product]['currency']}"),
        tax_category_id: params[:product]['tax_category_id'],
        shipping_category_id: params[:product]['shipping_category_id'],
        slug: params[:product]['name'].split(" ").join("-")
      }
    end

    def all_products
      all_products = Product
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 30)
    end
  end
end