import csv
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from xml.sax.saxutils import escape
styles=getSampleStyleSheet()
with open("Manufacturing/BOM_PCBWay_DRAFT.csv", newline="") as f:
    rows=list(csv.reader(f))
data=[[Paragraph(escape(v),styles["BodyText"]) for v in r] for r in rows]
widths=[28,52,26,105,82,135,60,42,42,42,100]
table=Table(data,colWidths=widths,repeatRows=1)
table.setStyle(TableStyle([("BACKGROUND",(0,0),(-1,0),colors.lightgrey),("GRID",(0,0),(-1,-1),0.3,colors.grey),("VALIGN",(0,0),(-1,-1),"TOP")]))
SimpleDocTemplate("output/pdf/BOM-DRAFT.pdf",pagesize=landscape(A4),leftMargin=24,rightMargin=24).build([Paragraph("LoRa DualBand — preliminary BOM",styles["Title"]),Paragraph("NOT FOR PROCUREMENT OR FABRICATION. Unverified MPNs and missing components.",styles["BodyText"]),Spacer(1,12),table])
