# derived view for creating a latest week dimension for some figures in dashboards

view: latest_dynamic_run {

  derived_table: {

    explore_source: dynamic_staging {

      column: transaction_week {}

      derived_column: transaction_week_max {
        # needs to find max date then cast back to string for the join
        sql: cast(max(date(transaction_week)) OVER (PARTITION BY NULL) as string) ;;
      }
    }
  }
  dimension: transaction_week {
    description: ""
    type: string
  }

  dimension: transaction_week_max {
    description: ""
    type: string
  }

}
