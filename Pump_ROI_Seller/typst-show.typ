#show: srm-report.with(
  $if(title)$
    title: "$title$",
  $endif$
  
  $if(params.years)$
    years: "$params.years$",
  $endif$
  
    $if(params.investment)$
    investment: "$params.investment$",
  $endif$
  
    $if(params.total_savings)$
    total_savings: "$params.total_savings$",
  $endif$
  
    $if(params.roi_percent)$
    roi_percent: "$params.roi_percent$",
  $endif$
  
    $if(params.payback_years)$
    payback_years: "$params.payback_years$",
  $endif$
  
    $if(params.project)$
    project: "$params.project$",
  $endif$

    $if(params.product)$
    product: "$params.product$",
  $endif$


    $if(params.efficiency_diff)$
    efficiency_diff: "$params.efficiency_diff$",
  $endif$
  
  
    $if(params.energy_savings)$
    energy_savings: "$params.energy_savings$",
  $endif$
  
  
    $if(params.mtbf_improvement)$
    mtbf_improvement: "$params.mtbf_improvement$",
  $endif$
  
  
    $if(params.downtime_savings)$
    downtime_savings: "$params.downtime_savings$",
  $endif$
  
  
    $if(params.maintenance_savings)$
    maintenance_savings: "$params.maintenance_savings$",
  $endif$
  
  
    $if(params.warranty)$
    warranty: "$params.warranty$",
  $endif$
  
)

#show: it => {
  // Define styles for key metrics
  let key-value-box(value, title) = {
    block(
      width: 100%,
      fill: rgb("#f9f9f9"),
      radius: 5pt,
      inset: 15pt,
      {
        align(center, text(size: 2.5em, fill: rgb("#3EB0E6"), weight: "bold", value))
        block(height: 0.5em)
        align(center, text(size: 1.2em, fill: rgb("#B2B2B2"), weight: "bold", title))
      }
    )
  }
  
  // Apply this to the document
  it
}

// Custom handler for divs with class "grid-container"
#show figure.where(kind: "quarto-grid-container"): body => {
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 10pt,
    ..body.body
  )
}



// Custom handler for grid items
#show figure.where(kind: "quarto-grid-item"): body => {
  body.body
}