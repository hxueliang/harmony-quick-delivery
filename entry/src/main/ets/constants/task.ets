/** 任务状态枚举 */
export enum TaskStatusEnum {
  /** 待提货 */
  WAITING = 1,
  /** 在途(在途和已交付) */
  LINE = 2,
  /* 待回车登记（已交货） */
  DELIVERED = 4,
  /** 已完成（已回车登记） */
  FINISH = 6
}
