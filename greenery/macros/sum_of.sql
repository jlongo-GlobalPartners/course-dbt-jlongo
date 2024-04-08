{%- macro sum_of(column_name, column_value) -%}
    sum(case when {{column_name}} = '{{column_value}}' then 1 else 0 end)
{%- endmacro -%}