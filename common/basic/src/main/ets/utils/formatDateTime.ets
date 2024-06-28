export function formatDateTime(date: Date, format: string): string {
  const options: Intl.DateTimeFormatOptions = {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false, // 24-hour format
  };

  const formattedDate = new Intl.DateTimeFormat('en-US', options).format(date)

  console.log('x_log', formattedDate)

  const formatted = format.replace(/yyyy/g, formattedDate.slice(6, 10))
    .replace(/MM/g, formattedDate.slice(0, 2))
    .replace(/dd/g, formattedDate.slice(3, 5))
    .replace(/hh/g, formattedDate.slice(12, 14))
    .replace(/mm/g, formattedDate.slice(15, 17))
    .replace(/ss/g, formattedDate.slice(18, 20))

  return formatted
}