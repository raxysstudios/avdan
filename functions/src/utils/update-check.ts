/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import type {
  Timestamp,
} from "firebase-admin/firestore";

export function isUpdated(a: any | undefined, b: any | undefined) {
  if (a?.status !== "public") return false;
  const x = a.lastUpdated as Timestamp | undefined;
  const y = b.lastUpdated as Timestamp | undefined;
  return (x?.toMillis() ?? 0) > (y?.toMillis() ?? 0);
}
