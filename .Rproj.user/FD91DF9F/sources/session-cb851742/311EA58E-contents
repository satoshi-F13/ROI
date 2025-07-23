#let srm-report(
  title: "title",
  years: none,
  investment: none,
  total_savings: none,
  roi_percent: none,
  payback_years: none,
  project: none,
  product: none,
  efficiency_diff: none,
  energy_savings: none,
  mtbf_improvement: none,
  downtime_savings: none,
  maintenance_savings: none,
  warranty: none,
  body,
) = {
  set text(
    font: "Noto Sans",
    size: 10.5pt,
  )
  set page(
    "a4",
    margin: (left: 1in, right: 1in, top: 0.7in, bottom: 1in),
    background: place(top, 
                    rect(fill: rgb("#3EB0E6"),
                    width: 100%,
                    height: 0.5in)),
    header: align(
      horizon,
      grid(
        columns: (80%, 20%),
        align(left,
              text(size: 20pt,
              fill: white,
              weight: "bold",
              title)),
        align(right,
              text(size: 12pt,
              fill: white,
              weight: "bold",
              project)),
      ),
    ),
    footer: align(
      grid(
        columns: (40%, 60%),
        align(horizon,
              context {
                text(fill: rgb("#A6AEBF"),
                    size: 12pt,
                    counter(page).display("1"))
              }),
        align(right,
              image("assets/sample_logo.png",
                    height: 50%)),
      )
    )
  )
  
  // Configure headings
  show heading.where(level: 1): set block(below: 0.8em)
  show heading.where(level: 1): underline
  show heading.where(level: 2): set block(above: 0.5cm, below: 0.5cm)
  
  // Paragraphs
  set par(
    justify: false,
    linebreaks: "optimized"
  )  
  
  // Define a style for links
  show link: set text(fill: rgb("#800080"))
  
  // Custom table styling 
  show table: table => {
    set table(
      width: 100%,
      inset: 8pt,
      stroke: (width: 1pt, color: rgba(255, 255, 255, 0.1))
    )
    table
  }
  
  // Section header style 
  show heading.where(level: 3): it => {
    set text(fill: rgb("#3EB0E6"), size: 1.5em)
    set block(above: 30pt, below: 15pt)
    it
  }
  
  // Create a function for key-value metrics
 let key-value-metric(value, key) = {
  box(
    width: 100%,
    fill: rgb("#f9f9f9"),
    radius: 5pt,
    inset: 15pt,
    [
      #align(center)[
        #text(size: 2.5em, fill: rgb("#3EB0E6"), weight: "bold", value)
        #block(height: 0.5em)
        #text(size: 1.2em, fill: rgb("#B2B2B2"), key)

      ]
    ]
  )
}
  
  // Main content
  body
  
 
}