module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t ".title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)",
      class: "btn fa fa-trash btn-danger")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
    child_index: "new_#{association}") do |builder|
    render association.to_s.singularize + "_fields", f: builder
   end
    link_to_function(name, "add_fields(this, '#{association}',
      '#{escape_javascript(fields)}')", class: "btn btn-info fa fa-plus")
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys
    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if
      html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"
    content_tag :a, name,
      html_options.merge(href: href, onclick: onclick)
  end

  def calc_price_of_order_detail product, quantity
    price = get_real_product_price product, Time.now
    price * quantity.to_i
  end

  def get_real_product_price product, time
    pro = Promotion.is_sale_of(product.id, time).first
    pro.nil? ? product.price : (product.price * pro.sale)
  end

  def load_categories_menu
    @tree = ""
    tree Category.all
  end

  private
  def tree categories, left = 0, right = nil, depth = -1
    @tree += "<ul class='dropdown-menu'>" if left == 0 && right == nil &&
      depth == -1
    categories.each do |category|
      if category.lft > left && (right.nil? || category.rgt <
        right) && category.depth == depth + 1
        categories_temp = categories.compact
        categories_temp.delete category
        @tree += "<li class='dropdown-submenu '>
          <a href='/categories/#{category.id}'>#{category.name}</a>"
        if category.rgt != (category.lft + 1)
          @tree += "<ul class='dropdown-menu' >"
          tree categories_temp, category.lft, category.rgt, category.depth
          @tree += "</ul>"
        end
        @tree += "</li>"
      end
    end
    @tree += "</ul>" if left == 0 && right.nil? && depth == -1
    @tree
  end
end
