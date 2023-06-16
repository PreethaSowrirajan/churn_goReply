view: churn_ecomm {
  sql_table_name: `churn_test.churn_ecomm`
    ;;

  dimension: churn_prediction {
    type: number
    sql: ${TABLE}.churn_prediction ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: churn_probability {
    type: number
    value_format: "0.000"
    sql: ${TABLE}.churn_probability ;;
  }

  # add a measure for churn probability multiplied by 52 week avg. when the churn flag is equal to 1
  measure: churn_opportunity {
    value_format: "[>=1000000][$£-en-GB]0.00,,\"M\";[>=1000][$£-en-GB]0.00,\"K\";[$£-en-GB]0.00"
    type: number
    sql:  case when ${churn_probability}>=0.5 then ${churn_probability}*${past_52_week_avg}
          else 0
          end ;;
  }

  # add a measure for churn probability multiplied by 52 week avg. when the churn flag is equal to 1
  measure: churn_opportunity_total {
    value_format: "[>=1000000][$£-en-GB]0.00,,\"M\";[>=1000][$£-en-GB]0.00,\"K\";[$£-en-GB]0.00"
    type: number
    sql:  sum(case when ${churn_probability}>=0.5 then ${churn_probability}*${past_52_week_avg}
          else 0
          end) ;;
  }

  dimension: currently_churned {
    type: number
    sql: ${TABLE}.currently_churned ;;
  }

  dimension: customer_code {
    type: string
    sql: FARM_FINGERPRINT(cast(${TABLE}.CustomerCode as string)) ;;
  }

  dimension: customer_code_unmasked {
    type: string
    sql: ${TABLE}.CustomerCode ;;
  }

  dimension: dynamic_churn_item {
    type: string
    label: "Category"
    sql: ${TABLE}.DynamicChurnItem ;;
  }

  dimension: past_52_week_avg {
    type: number
    value_format: "[>=1000000][$£-en-GB]0.00,,\"M\";[>=1000][$£-en-GB]0.00,\"K\";[$£-en-GB]0.00"
    sql: ${TABLE}.past_52_week_avg ;;
  }

  dimension: past_52_week_visits{
    type: number
    sql: ${TABLE}.past_52_week_visits ;;
  }

  dimension: past_13_week_avg {
    type: number
    value_format: "[>=1000000][$£-en-GB]0.00,,\"M\";[>=1000][$£-en-GB]0.00,\"K\";[$£-en-GB]0.00"
    sql: ${TABLE}.past_13_week_avg ;;
  }

  dimension: past_13_week_visits {
    type: number
    sql: ${TABLE}.past_13_week_visits ;;
  }

  dimension: past_4_week_avg {
    type: number
    value_format: "[>=1000000][$£-en-GB]0.00,,\"M\";[>=1000][$£-en-GB]0.00,\"K\";[$£-en-GB]0.00"
    sql: ${TABLE}.past_4_week_avg ;;
  }

  dimension: past_4_week_visits {
    type: number
    sql: ${TABLE}.past_4_week_visits ;;
  }

  dimension: sector_ift {
    type: string
    label: "Login Device"
    sql: ${TABLE}.SectorIFT ;;
  }

  dimension: segment1 {
    type: string
    label: "Item Type"
    sql: ${TABLE}.Segment1 ;;
  }

  dimension: transaction_week {
    type: string
    sql: ${TABLE}.TransactionWeek ;;
  }

  measure: count {
    type: count
    drill_fields: [dynamic_churn_item]
  }

  measure: count_active {
    type: count
    filters: [currently_churned: "0"]
    drill_fields: [dynamic_churn_item]
  }

  measure: count_predicted_churn {
    type: count
    filters: [churn_prediction: "1",currently_churned: "0"]
    drill_fields: [dynamic_churn_item]
  }

  measure: count_currently_churned {
    type: count
    filters: [currently_churned: "1"]
    drill_fields: [dynamic_churn_item]
  }

}
