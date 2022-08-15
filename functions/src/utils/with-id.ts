/* eslint-disable require-jsdoc */
import type {
  DocumentSnapshot,
} from "firebase-admin/firestore";

export function withId(s: DocumentSnapshot) {
  return {
    id: s.id,
    ...s.data(),
  };
}
