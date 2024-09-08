// Function to get a string, containing the course and the speciality. Used in titlepage
#let get_course_speciality(group) = {
  let specialities = (
    [Фундаментальная информатика и информационные технологии],
    [Информатика и вычислительная техника],
    [Компьютерная безопасность],
    [Математическое обеспечение и администрирование информационных систем],
    [Программная инженерия],
    [Педагогическое образование],
    [Информатика и вычислительная техника],
    [Математическое обеспечение и администрирование информационных систем],
    [Системный анализ и управление]
  )

  let result = str(group).at(0) + " курс"

  if str(group).at(1) == "7" {
    result += " (магистратура)"

    if str(group).at(2) == "1" {
      result += ", «" + specialities.at(6) + "»"
    } else if str(group).at(2) == "3" {
      result += ", «" + specialities.at(7) + "»"
    }

    return result
  }

  let id = int(str(group).at(1)) - 1;
  
  if id >= 0 and id <= 8 {
    result += ", «" + specialities.at(id) + "»"
  }

  return result
}

// Titlepage builder
#let make_titlepage(
  info: ()
) = {
  set align(center)
  
  v(2em)
  text(size: 2em,
       weight: 700,
       str(info.title))

  v(1em)
  text(size: 1.25em,
       str(info.author) + "\n" + get_course_speciality(int(info.group)))

  set align(center)
  text(size: 1.25em,
       str(info.city) + ", " + str(info.year))
}

// TOC builder
#let make_toc(
  info: ()
) = {
  outline(indent: 0%,
          title: [Содержание])
  pagebreak(weak: true)
}

// Main configuration script
#let conf(
  meta: (),
  toc: (),
  content
) = {
  show raw: set text(font: "JetBrains Mono")

  show raw.where(block: true): code => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    code
  }
  
  set text(
    font: "Cambria",
    size: 14pt,
    ligatures: true,
  )

  make_titlepage(info: meta)
  make_toc(info: toc)
  
  content
}