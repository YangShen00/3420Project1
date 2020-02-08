/** An instance maintains the time of day. class invariant: set of comments that describe the
 * meanings of the field and constraints on them. */
public class Time {
	/** hour of the day, in 0..23. */
	private int hr;
	/** minute of the hour, in 0..59. */
	private int min;

	/** Constructor: an instance with hour h and minute m. <br>
	 * Precondition: h in 0..23, m in 0..59 */
	public Time(int h, int m) {
		hr= h;
		min= m;
	}

	/** return true iff this time comes before t.<br>
	 * Precondition: t is not null. */
	public boolean before(Time t) {
		return false;
	}

	/** Return true iff this time is the same as t;<br>
	 * Precondition: t is not null. */
	public boolean equals(Time t) {
		assert t != null;
		return hr == t.hr && min == t.min;
	}

	/** return the hour of the day */
	public int getHour() {
		return hr;
	}

	/** return the minute of the hour */
	public int getMinute() {
		return min;
	}

	/** Set the hour to h. Precondition: h in 0..23 */
	public void setHour(int h) {
		hr= h;
	}

	/** return a repr of this object, e.g. 04:20 */
	@Override
	public String toString() {
		return prepend0(hr) + ":" + prepend0(min);
	}

	/** return s with 0 prepended if s is 1 char one */
	public String prepend0(int s) {
		if (0 <= s && s < 10) return "0" + s;
		return "" + s;
	}
}
