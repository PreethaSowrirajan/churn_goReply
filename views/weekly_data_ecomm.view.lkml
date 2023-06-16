view: weekly_data_ecomm {
  sql_table_name: `churn_test.weekly_data`
    ;;

  dimension: category1 {
    type: string
    sql: ${TABLE}.category1 ;;
  }

  dimension: category2 {
    type: string
    sql: ${TABLE}.category2 ;;
  }

  dimension: category3 {
    type: string
    sql: ${TABLE}.category3 ;;
  }

  dimension: customer_code {
    type: string
    sql: ${TABLE}.CustomerCode ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.CustomerName ;;
  }

  dimension: master_brand_parent {
    type: string
    sql: ${TABLE}.MasterBrandParent ;;
  }

  dimension: master_product_name {
    type: string
    sql: ${TABLE}.MasterProductName ;;
  }

  dimension: sector_ift {
    type: string
    sql: ${TABLE}.SectorIFT ;;
  }

  dimension: segment1 {
    type: string
    sql: ${TABLE}.segment1 ;;
  }

  dimension: segment2 {
    type: string
    sql: ${TABLE}.segment2 ;;
  }

  dimension: segment3 {
    type: string
    sql: ${TABLE}.segment3 ;;
  }

  dimension: seasonal_flag {
    type: number
    sql:  case when ${segment3} in('Festivals/Events','Park/Outdoor','Holiday/Caravan Park','Education') then 1
      else 0 end;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: transaction_week {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.TransactionWeek ;;
  }

  dimension: weekly_hectolitres {
    type: number
    sql: ${TABLE}.WeeklyHectolitres ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_weekly_hectolitres {
    type: sum
    sql: ${weekly_hectolitres} ;;
  }

  measure: average_weekly_hectolitres {
    type: average
    sql: ${weekly_hectolitres} ;;
  }

  dimension: weekly_sales {
    type: number
    sql: ${TABLE}.WeeklySales ;;
  }

  measure: count {
    type: count
    drill_fields: [master_product_name, customer_name]
  }
}
