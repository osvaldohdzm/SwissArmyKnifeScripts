Attribute VB_Name = "M�dulo1"
Sub Uppercase()
  For Each Cell In Selection
    If Not Cell.HasFormula Then
      Cell.Value = UCase(Cell.Value)
    End If
  Next Cell
End Sub
