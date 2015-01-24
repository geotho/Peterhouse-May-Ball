class CurrencyInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    template.content_tag(:div, :class => 'input-group') do
      template.content_tag(:div, '£', :class => 'input-group-addon') +
          @builder.text_field(attribute_name, merged_input_options) +
          template.content_tag(:div, '.00', :class => 'input-group-addon')
    end
  end
end
