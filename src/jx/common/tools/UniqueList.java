package jx.common.tools;


import java.util.*;

/**
 * <code>UniqueList</code> is a successor of <code>java.util.Vector</code> to provide a collection that
 * contains no duplicate elements, more formally such that e1.compareTo(e2) == 0. <p>
 *
 * As from above, the collection implies that all its elements must implement <code>Comparable</code> interface.
 * <p>
 * The collection is kept ordered whenever elements added or removed and besides uniqueness it is to provide fast
 * element search based again on e1.compareTo(e2) values.
 *
 * @author Vlad Ilyushchenko
 */
public class UniqueList extends Vector {

    public synchronized boolean add(Object obj) {
        return add(obj, null);
    }

    protected synchronized boolean add(Object obj, Comparator c) {
        if (size() == 0)
            return super.add(obj);
        else {
            int index;
            index = c == null ? Collections.binarySearch(this, obj) : Collections.binarySearch(this, obj, c);
            if (index < 0) {
                if (-index - 1 >= size())
                    super.add(obj);
                else
                    super.insertElementAt(obj, -index - 1);
            }
            return index < 0;
        }
    }

    public synchronized void insertElementAt(Object obj, int index) {
        add(obj);
    }

    public synchronized boolean addAll(Collection c) {
        boolean ok = this != c;
        if (ok) {
            Iterator iterator = c.iterator();
            while (iterator.hasNext()) {
                ok = this.add(iterator.next()) && ok;
            }
        }
        return ok;
    }
}
